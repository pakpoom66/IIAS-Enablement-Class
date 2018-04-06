# Authenticating to the POC Network through the BSO firewall with your IBM Intranet Credentials.  

## Open command/terminal window on your workstation:  

   * Mac: Open Terminal (/Applications/Utilities.Terminal.app) or iTerm (/Applications/iTerm.app)  
     `$ telnet 9.30.106.115`  

	  ```    
	  Trying 9.30.106.115...
	  Connected to 9.30.106.115.
	  Escape character is '^]'.

	  SVL Private Network (SPN) Authentication : Enter Your Intranet ID and Password (e.g. johndoe@us.ibm.com). To request access to a SPN Restrictive VLAN, follow the instructions here: http://w3.svl.ibm.com/network/spn/vlanaccess.html.
	  Username: <your-IBM-intranet-ID>

	  Password: <your-IBM-intranet-password>
	  SPN Authentication Successful
	  Connection closed by foreign host.
	  ```  
	 ![](img src="../../Images/authenticate.gif") 

   * Windows: Open the Command Prompt  
     `->Windows->All Programs->Accessories->Command Prompt`

     Enter the following command  
     `telnet 9.30.106.115`  
     > Note: Use your IBM Intranet userid and password.

     > Note: if you don't have telnet enabled on Windows run the following command at the Command Prompt:
     `pkgmgr /iu:"TelnetClient"`
