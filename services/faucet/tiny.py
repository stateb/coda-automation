import discord
import re
import os
import asyncio
import concurrent.futures
from faucet import faucet_transaction

LISTENING_CHANNELS = ["faucet"]
FAUCET_APPROVE_ROLE = "faucet-approvers"
CODA_FAUCET_AMOUNT = "100"
# A Dictionary to keep track of users
# who have requested faucet funds 
ACTIVE_REQUESTS = {}
DISCORD_API_KEY = os.environ.get("DISCORD_API_KEY")

executor = concurrent.futures.ThreadPoolExecutor(max_workers=5)
client = discord.Client()
@client.event
async def on_ready():
    print('We have logged in as {0.user}'.format(client))

@client.event
async def on_message(message):
    # Dont listen to messages from me
    if message.author == client.user:
        return

    # Check if the grumpus is listening
    if message.content.startswith('$tiny') and message.channel.name in LISTENING_CHANNELS:
        await message.channel.send('You summoned me?')

    # Help me grumpus! 
    if message.content.startswith('$help') and message.channel.name in LISTENING_CHANNELS:
        help_string = '''
Woof! I can help you get some Coda on one of our Test Nets. 
All you have to do is send a message in the #faucet channel with the following contents: 

`$request <public-key>`

Once a mod approves, `100 CODA` will be sent to the requested address!
        '''

        await message.channel.send(help_string)

    # Act as a faucet, responding to messages of the form: 
    #   $request <public-key>
    if message.content.startswith('$request') and message.channel.name in LISTENING_CHANNELS:
        channel = message.channel
        roles = message.guild.roles
        mod_role = next(role for role in roles if role.name == FAUCET_APPROVE_ROLE).mention
        requester = message.author

        # If we're not already tracking a request for this user
        if requester.id not in ACTIVE_REQUESTS:
            ACTIVE_REQUESTS[requester.id] = {
                "channel": channel,
                "requester": requester
            }
            print(ACTIVE_REQUESTS)
        # Otherwise, ignore this request
        else: 
            please_wait_text = "Hey {}, please wait or cancel your previous request for faucet funds!".format(requester.mention)
            await channel.send(please_wait_text)
            return

        try: 
            # Try to parse the message with regex
            regexp = "\$request (\w+)"
            m = re.search(regexp, message.content)
            if m:
                recipient = m.groups()[0]
                amount = CODA_FAUCET_AMOUNT
                print(recipient)
                # Request transaction approval from the mods 
                approval_text = 'Hey {}, should I approve this transaction?: \nRequester: {}\nRecipient: {}\nAmount: {}\n *To cancel, react with ❌*'.format(mod_role, requester.mention, recipient, amount)
                approval_message = await channel.send(approval_text)

                # Check if a mod has approved the request
                def check_approval(reaction, user):
                    print("check approval", reaction)
                    print(user.roles)
                    return reaction.message.id == approval_message.id and FAUCET_APPROVE_ROLE in [str(x) for x in user.roles] and str(reaction.emoji) == '👍'
            
                # Check if a user has cancelled their request
                def check_cancel(reaction, user):
                    print("check cancel", reaction, reaction.message.id == approval_message.id and user == message.author and str(reaction.emoji) == '❌')
                    return reaction.message.id == approval_message.id and user == message.author and str(reaction.emoji) == '❌'
                
                try:
                    # This is weird but in the docs there is a note explaining why you have to create tasks
                    # outside the call to `wait` instead of passing coroutines directly
                    #
                    # https://docs.python.org/3/library/asyncio-task.html#asyncio.wait
                    cancel = asyncio.create_task(client.wait_for('reaction_add', check=check_cancel))
                    approval = asyncio.create_task(client.wait_for('reaction_add', check=check_approval))

                    # Make sure approval reactions are for the right message
                    done, unfinished = await asyncio.wait({cancel, approval},
                                                        return_when=asyncio.FIRST_COMPLETED)
                    for task in unfinished:
                        task.cancel()
                    if len(unfinished) != 0:
                        await asyncio.wait(unfinished)

                # Transaction was not approved
                except asyncio.TimeoutError:
                    await channel.send('Transaction Not Approved in Time: 👎')
                    
                # Transaction was approved
                else:
                    if approval in done:
                        # Alert in the channel that the transaction approved
                        await channel.send('Woof! -- Transaction Approved, fetching your funds...')
                        # Make call to ansible 
                        loop = asyncio.get_event_loop()
                        output = await loop.run_in_executor(executor, faucet_transaction, recipient, amount)
                        # Collect output and return it to the channel
                        await channel.send('{} Transaction Sent! Output from Daemon: ```{}```'.format(requester.mention, output))
                        print("Approved!")
                    elif cancel in done:
                        await channel.send('Transaction Cancelled!')
                        print("Cancelled...")

            else:
                print(message.content)
                error_message = '''Grrrrr... Invalid Parameters!!
                `$request <public-key> <amount>`
                '''
                await message.channel.send(error_message)
        finally:
            del ACTIVE_REQUESTS[requester.id]

client.run(DISCORD_API_KEY)
