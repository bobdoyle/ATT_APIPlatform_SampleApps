<!-- 
Licensed by AT&T under 'Software Development Kit Tools Agreement.' September 2011
TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION: http://developer.att.com/sdk_agreement/
Copyright 2011 AT&T Intellectual Property. All rights reserved. http://developer.att.com
For more information contact developer.support@att.com
-->
<%
response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.att.api.dc.handler.DCHandler" %> 
<%@ page import="com.att.api.dc.model.DeviceInfo" %>
<%@ page import="com.att.api.util.DateUtil" %>
<%@ include file="oauth.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <title>AT&amp;T Sample DC Application - Get Device Capabilities Application</title>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
    <link rel="stylesheet" type="text/css" href="style/common.css" />
</head>
<body>
<%
	String accessToken = (String) session.getAttribute("accessToken");
	
	DCHandler dchandler = new DCHandler(request,endpoint,accessToken);
	DeviceInfo deviceInfo = null;
	if (accessToken != null)
	{
		deviceInfo = dchandler.processRequest();
	}
	else if (accessToken ==  null)
	{
		if (session.getAttribute("errorResponse") != null)
		{
			deviceInfo = new DeviceInfo();
			deviceInfo.setStatus(false);
			String errorResponse = (String) session.getAttribute("errorResponse");
			deviceInfo.setErrorResponse(errorResponse);
			session.removeAttribute("errorResponse");
		}
		else if(code.length() == 0) 
		{
			//For the first time, we dont have access token, so we redirect to authenticate client id
		   	response.sendRedirect(FQDN + "/oauth/authorize?client_id=" + client_id + "&scope=" + scope + "&redirect_uri=" + redirectURL);
	    }
	 }
%>	 
    <div id="container">
        <!-- open HEADER -->
        <div id="header">
            <div>
                <div class="hcRight"><%=DateUtil.getServerTime()%></div>
                <div class="hcLeft">Server Time:</div>
            </div>
            <div>
                <div class="hcRight">

                    <script language="JavaScript" type="text/javascript">
                        var myDate = new Date();
                        document.write(myDate);
                    </script>
                    
                </div>
                <div class="hcLeft">
                    Client Time:</div>
            </div>
            <div>
                <div class="hcRight">
                    <script language="JavaScript" type="text/javascript">
                        document.write("" + navigator.userAgent);
                    </script>
                </div>
                <div class="hcLeft">
                    User Agent:</div>
            </div>
            <br clear="all" />
        </div>
        <!-- close HEADER -->
        <div>
            <div class="content">
                <h1>
                    AT&amp;T Sample DC Application - Get Device Capabilities Application</h1>
                <h2>
                    Feature 1: Get Device Capabilities</h2>
            </div>
        </div>
        <br />
        <br />
        <div class="extra">
            <table>
                <tbody>
                    <div id="extraleft">
                        <div class="warning">
                            <strong>Note:</strong><br />
                            <strong>OnNet Flow:</strong> Request Device Capabilities details from the AT&T network
                            for the mobile device of an AT&T subscriber who is using an AT&T direct Mobile data
                            connection to access this application.
                            <br />
                            <strong>OffNet Flow:</strong> Where the end-user is not on an AT&T Mobile data connection
                            or using a Wi-Fi or tethering connection while accessing this application. This
                            will result in an HTTP 400 error.
                        </div>
                    </div>
                </tbody>
            </table>
        </div>
        <br clear="all" />
        <%
        if (deviceInfo != null && deviceInfo.isStatus())
        {
        %>
	        <div class="successWide" id="tb_dc_output" visible="false">
	            <strong>SUCCESS:</strong><br />
	            Device parameters listed below.
	        </div>
	        <br />
	        <div align="center">
	            <table width="500" cellpadding="1" cellspacing="1" border="0" runat="server" id="tbDeviceCapabilities"
	                visible="false">
	                <thead>
	                    <tr>
	                        <th width="50%" class="label">
	                            Parameter
	                        </th>
	                        <th width="50%" class="label">
	                            Value
	                        </th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>TypeAllocationCode</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getDeviceId() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>Name</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getName() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>Vendor</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getVendor() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>Model</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getModel() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>FirmwareVersion</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getFirmwareVersion() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>UaProf</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getUaProf() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>MmsCapable</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getMmsCapable() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>AssistedGps</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getAssitedGps() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>LocationTechnology</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getLocationTechnology() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>DeviceBrowser</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getBrowserType() %></label>
	                            </em>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="cell" align="center">
	                            <em>WapPushCapable</em>
	                        </td>
	                        <td class="cell" align="center">
	                            <em>
	                                <label id="lblTypeAllocationCode"><%=deviceInfo.getWapPushCapable() %></label>
	                            </em>
	                        </td>
	                    </tr>
					</tbody>
				</table>        
	        </div>
        <%
        }
        else if (deviceInfo != null && !deviceInfo.isStatus())
        {
        %>
	        <div id="tbDeviceCapabError" runat="server" cellspacing="1" class="errorWide" visible="false">
	            <b>ERROR:</b><br />
	            <label id="lblErrorMessage"><%=deviceInfo.getErrorResponse() %></label>
	        </div>
        <%
        }
        %>
        <br clear="all" />
        <div id="footer">
            <div style="float: right; width: 20%; font-size: 9px; text-align: right">
                Powered by AT&amp;T Virtual Mobile</div>
            <p>
                &#169; 2012 AT&amp;T Intellectual Property. All rights reserved. <a href="http://developer.att.com/"
                    target="_blank">http://developer.att.com</a>
                <br />
                The Application hosted on this site are working examples intended to be used for
                reference in creating products to consume AT&amp;T Services and not meant to be
                used as part of your product. The data in these pages is for test purposes only
                and intended only for use as a reference in how the services perform.
                <br />
                For download of tools and documentation, please go to <a href="https://devconnect-api.att.com/"
                    target="_blank">https://devconnect-api.att.com</a>
                <br />
                For more information contact <a href="mailto:developer.support@att.com">developer.support@att.com</a></p>
        </div>
    </div>
    <p>
        &nbsp;</p>
</body>
</html>
