package com.newtg;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProcessInputServlet
 */
@WebServlet("/processInputs")
public class ProcessInputServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessInputServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Runtime.getRuntime().exec("/usr/bin/Rscript /var/lib/jenkins/workspace/Predictive_Analytics_R/predict_new.R");
		BufferedReader reader = null;
        Process shell = null;
        String numActive = request.getParameter("numActive");
        String numDaysActive = request.getParameter("numDaysActive");
        String loc = request.getParameter("loc");
        String numReopened = request.getParameter("numReopened");
        String numDefects = request.getParameter("numDefects");
        double x1= Double.parseDouble(numActive)*Integer.parseInt(numDefects);
        double x2= Double.parseDouble(numDaysActive)*Integer.parseInt(numDefects);
        double x3= Double.parseDouble(loc)*Integer.parseInt(numDefects);
        double x4= Double.parseDouble(numReopened)*Integer.parseInt(numDefects);
		System.out.println("Executing doGet with numActive:"+x1+" numDaysActive:"+x2+" loc:"+x3+" numReopened:"+x4);
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        StringBuilder str=new StringBuilder();
        try {
            shell = Runtime.getRuntime().exec("/usr/bin/Rscript /var/lib/jenkins/workspace/Predictive_Analytics_R/predict_new.R "+x1+" "+x2+" "+x3+" "+x4);
        	//shell = Runtime.getRuntime().exec("cmd.exe /c \"'C:\\Program Files\\R\\R-3.4.0\\bin\\Rscript.exe' 'E:\\Confidential\\Case Studies\\Predictive Analytics\\POC on ML for QA\\ML_v2\\Defects_Modi\\predict_new.R' "+numActive+" "+numDaysActive+" "+loc+" "+numReopened+"\"");
        	//String path="'C:\\Program Files\\R\\R-3.4.0\\bin\\Rscript E:\\Confidential//Case Studies//Predictive Analytics//POC on ML for QA//ML_v2//Defects_Modi//predict_new.R 300 300 7000 100'";
        	//shell = Runtime.getRuntime().exec("cmd.exe /c "+path);
        	//shell = Runtime.getRuntime().exec("C:/Program Files/R/R-3.4.0/bin/Rscript.exe E:/Confidential/predict_new.R "+numActive+" "+numDaysActive+" "+loc+" "+numReopened);
        	shell.waitFor();
            reader = new BufferedReader(new InputStreamReader(shell.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
            	String x=line.substring(5,line.length()-1);
                str.append(x+"<br/>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Finished doGet with string:"+str.toString());
        String output = str.toString();
        out.println(output);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
	}

}
