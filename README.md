# starknet
## Hello everyone.  This tool should help with manage starknet nodes.
### What can he do
- connect to server
- setup server (install docker and cron)
- start docker container with latest version starknet
- create cron job for automatic start docker container if something crashed or exist new version starknet
- check status all servers

To work with the script, you only need bash shell

# Steps for use
```sh
git clone https://github.com/dimanchezzz/starknet.git
```
-----
Create key pairs for connect to your servers
 - https://kb.iu.edu/d/aews
 - https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/

quikly describe : Your every node should contains authorized_keys file with public key and your place which you use for start script shuld containd private key

My node server 

![image](https://user-images.githubusercontent.com/31654635/202990755-91348b0a-02de-43f5-b69e-1ca5ae3f4cd7.png)

My server which I using for start script  connect.sh ( need only contabo file. contabo - my private key)

![image](https://user-images.githubusercontent.com/31654635/202991046-f684fb8d-b726-423a-8828-dd63787d3361.png)

After that you should edit connect.sh file

![image](https://user-images.githubusercontent.com/31654635/202991867-288898fd-2501-46a9-9ab8-6a67aac08393.png)

you should edit path to your private key

in my case correct path 

![image](https://user-images.githubusercontent.com/31654635/202991993-c2275137-5e2f-4840-8031-d532c756a2cb.png)

-------
You should change you servers list

![image](https://user-images.githubusercontent.com/31654635/202992392-709d9780-1b96-48f6-9e6b-0a6c3186303e.png)

and change your keys from alchemy

![image](https://user-images.githubusercontent.com/31654635/202992986-fa44f9b9-d4d9-41e6-a0b7-604cc81019c8.png)

my configuration 

![image](https://user-images.githubusercontent.com/31654635/202993217-e6eacd1e-a4cc-4938-9efe-eb111ed75025.png)

Complete!

-------

Now you can config you servers 


![image](https://user-images.githubusercontent.com/31654635/202993642-b7a13c88-9659-4ccc-b209-98bf6245a77f.png)


next step: start container
next step: create cron job

Complete!
-------------------------------

Now you can check status 

![image](https://user-images.githubusercontent.com/31654635/202994394-522d0b61-d464-4b3b-8373-6eb3a57e5415.png)

-----------------

Please contact with me if you have some question: 
- Discord dimanchez#5704
- Telegram https://t.me/Bomj_Koladun






 
