# **Azure Naming Tool Codebase Documentation**

---

## **1. Introduction**  
The Azure Naming Tool provides a centralized platform for generating resource names that align with organizational policies. This documentation outlines how to deploy, configure, and manage the tool in an Azure Web App environment.  

---

## **2. Deployment on Azure**

### **2.1 Prerequisites**
- An Azure subscription with sufficient permissions to deploy Web Apps.  
- Access to the naming policies and configuration files (if applicable).  
- .NET Core 6.0 or higher installed locally for testing (optional).  

### **2.2 Deployment Steps**
1. **Create an Azure Web App**:  
   - Navigate to the Azure Portal and create a new Web App.  
   - Choose the runtime stack: `.NET Core 6.0`.  
   - Configure the deployment region and hosting plan.  

2. **Deploy the Code**:  
   - Use Azure DevOps, GitHub Actions, or the Azure CLI for deployment. Example CLI command:  
     ```bash
     az webapp deployment source config --name <app_name> --resource-group <resource_group> --repo-url <repository_url>
     ```

3. **Set Environment Variables**:  
   - Access the Web App’s configuration settings in the Azure Portal.  
   - Add any required app settings, such as database connection strings or API keys.  

4. **Test the Deployment**:  
   - Open the app URL (e.g., `https://<app_name>.azurewebsites.net`) and confirm functionality.  

---

## **3. Key Features**  

### **3.1 Resource Name Generation**  
- Generate names for Azure resources based on organizational standards.  
- Support for single and multiple resource type naming.  

### **3.2 Configuration Customization**  
- Define naming components such as environment, resource type, and location.  
- Set delimiters and global configuration options.  

### **3.3 User Management**  
- Admin users can manage configurations, security settings, and API keys.  

### **3.4 Logs and Monitoring**  
- View logs for generated names and admin changes.  
- Export logs for auditing purposes.  

---

## **4. Using the Application**

### **4.1 First-Time Setup**  
1. Launch the app and set an **Admin password** when prompted.  
2. Navigate through the provided pages:  
   - **Home**: Overview of the tool.  
   - **Configuration**: Set naming policies and guidelines.  
   - **Generate**: Create resource names based on selected criteria.  

### **4.2 Ongoing Maintenance**  
- Regularly update configurations as organizational policies evolve.  
- Monitor logs for compliance and troubleshooting.  

---

## **5. Documentation**  
For detailed documentation on customizing and configuring the Azure Naming Tool, please refer to the **[AzureNamingToolDocumentation.pdf](./AzureNamingToolDocumentation.pdf)** file located in the root directory of this repository.  

---

## **6. Codebase**  
The codebase for the Azure Naming Tool is hosted on GitHub. You can access the repository [here](https://github.com/KXS-UTD/AzureNamingTool).  
