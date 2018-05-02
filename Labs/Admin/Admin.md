#   IBM Integrated Analyics System - Administration  

## This will be the admin lab to explore the administration of IIAS.

1. From the Virtual Machine, launch the Cisco VPN ![Cisco VPN](./images/cisco.png)
  * Verify that `sccvpn.im-ies.ibm.com` is in the **Connect to:** Box
  * Click **Connect** button.
  ![Connect VPN](./images/vpnlogin.png)
  * Enter your VPN user id and password.  **Note:** If you do not have this id, follow the [partner access document](../../../PartnerAccess.md)
  ![User ID and Password](./images/userpassword.png)
1. From the Virtual Machine launch Firefox.
1. Book marked you will find a link to https://10.50.88.240:8443/console  
1. Login with user/password provided by the instructor. If you are running this outside of class, use your id provided.
  *  Note: This interface is very similar to Db2 Warehouse and DSX Local, as they are all build with Data Server Manager as the admin UI.  


- Walk them through the Dashboard,
- Show the nodes and cluster log
- Service available and their current state.  
- Then move to Alerts, show them that redis pod is work working well
-- Move to Pods show them how to redeploy it.  ( Show the the red exclam (!)  then move to the right and Click the curly arrow on the right,   it will not fix it as this really needs repair)  
-Show them the User Management
 -- Show them that you are admin and they will get user ids.  This is the current level of security.  
 -- Show the where to connect an LDAP, this would be the same place in IIAS/Sailfish.
