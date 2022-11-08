apt update -y
apt upgrade -y
apt install mc -y

#install docker
 sudo apt-get install -f \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
 sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


mkdir /DATA
mkdir /DATA/ipcheck
#install dotnet
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

#Install the SDK
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0

#Install the runtime
sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-6.0

sudo apt install -y dotnet-sdk-6.0

#
sudo apt-get install -y dotnet-runtime-6.0

#install Visual Code
sudo apt install -y gnupg2 software-properties-common apt-transport-https curl
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update -y
sudo apt install code -y

#Build
dotnet new console --output /DATA/ipcheck/. --name ipcheck --framework net6.0



#Create files
sudo cat <<  EOF >  /DATA/Program.cs
#------------------------------------
public class Program
{
    public static void Main(string[] args)
    {
        // Check if network is available
        if (System.Net.NetworkInformation.NetworkInterface.GetIsNetworkAvailable())
        {
            System.Console.WriteLine("Current IP Addresses:");

            // Get host entry for current hostname
            string hostname = System.Net.Dns.GetHostName();
            System.Net.IPHostEntry host = System.Net.Dns.GetHostEntry(hostname);

            // Iterate over each IP address and render their values
            foreach(System.Net.IPAddress address in host.AddressList)
            {
                System.Console.WriteLine($"\t{address}");
            }
        }
        else
        {
            System.Console.WriteLine("No Network Connection");
        }
    }
}
EOF

###

sudo cat <<  EOF >  /DATA/Dockerfile
# Start using the .NET 6 SDK container image
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build

# Change current working directory
WORKDIR /app

# Copy existing files from host machine
COPY . ./

# Publish application to the "out" folder
RUN dotnet publish --configuration Release --output out

# Start container by running application DLL
ENTRYPOINT ["dotnet", "out/ipcheck.dll"]

EOF

mkdir /DATA/tmp
code --no-sandbox /DATA/ipcheck/ --user-data-dir /DATA/tmp

cp /DATA/Program.cs /DATA/ipcheck/Program.cs -f
cp /DATA/Dockerfile /DATA/ipcheck/ -f

##install Az CLI
sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash


#az vm create --resource-group lab5-rg --name lab5-rg-vm2 --image Debian --admin-username ksi --admin-password "Password1234"

 vi Program.cs
 dotnet run
az login
az acr build --registry acrlab5 --image ipcheck:latest .
