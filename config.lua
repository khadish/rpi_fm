-- One of the work mailservers is slow.
-- The time in seconds for the program to wait for a mail server's response (default 60)
options.timeout = 120

-- According to the IMAP specification, when trying to write a message to a non-existent mailbox, the server must send a hint to the client, whether it should create the mailbox and try again or not. However some IMAP servers don't follow the specification and don't send the correct response code to the client. By enabling this option the client tries to create the mailbox, despite of the server's response. 
options.create = true

-- By enabling this option new mailboxes that were automatically created, get also subscribed; they are set active in order for IMAP clients to recognize them
options.subscribe = true

-- Normally, messages are marked for deletion and are actually deleted when the mailbox is closed. When this option is enabled, messages are expunged immediately after being marked deleted.
options.expunge = true


function delSpamWP()
		    file = 'wpp.txt'
		    pass = io.open(file):read()
		account2 = IMAP {
		    server = "imap.wp.pl",
		    username = "khadish",
		    ssl = "tls1",
		    password = pass
			}
		msgs =  account2.INBOX:contain_from('/WP') 
	--      account2.INBOX:contain_from('Log') +
	--      account2.INBOX:contain_subject('yum')
		account2.INBOX:mark_seen(msgs)
		account2.INBOX:move_messages(account2['Kosz'], msgs)
end
         
--         become_daemon(600, delSpamWP)

function delSpamTLEN()
		    file = 'o2p.txt'
		    pass = io.open(file):read()
	print("analizuje TLEN")
		konto_tlen = IMAP {
		    server = "poczta.o2.pl",
		    username = "khadish",
		    password = pass,
		    port = 993,
		    ssl = "tls1"
			}
	--	msgs =  konto_tlen.INBOX:contain_from('/WP') 
	--      konto_tlen.INBOX:contain_from('Log') +
	msgs =  konto_tlen.SPAM:contain_field('Subject', 'Bonus')
		konto_tlen.SPAM:mark_seen(msgs)
		konto_tlen.SPAM:move_messages(konto_tlen['Trash'], msgs)
	msgs =  konto_tlen.INBOX:contain_from('noreply@clrpma17.pl')
		konto_tlen.INBOX:move_messages(konto_tlen['Trash'], msgs)
	msgs =  konto_tlen.INBOX:contain_body('STARWEB')
		konto_tlen.INBOX:move_messages(konto_tlen['Trash'], msgs)
	msgs =  konto_tlen.SPAM:contain_from('Vegas VIP Casino')
		konto_tlen.SPAM:mark_seen(msgs)
		konto_tlen.SPAM:move_messages(konto_tlen['Trash'], msgs)
	msgs =  konto_tlen.SPAM:contain_subject('Zarabianie')
		konto_tlen.SPAM:mark_seen(msgs)
		konto_tlen.SPAM:move_messages(konto_tlen['Trash'], msgs)
end
	
delSpamWP()
--delSpamTLEN()

	-- Get a list of the available mailboxes and folders
-- mailboxes, folders = account2:list_all()
-- print(mailboxes[0])
-- -- Get a list of the subscribed mailboxes and folders
-- mailboxes, folders = account2:list_subscribed()

-- for k=1, #folders do
--	 print(folders[k])
-- end
-- for k=1, #mailboxes do
--	 print(mailboxes[k])
-- end
