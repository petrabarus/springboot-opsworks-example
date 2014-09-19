Chef::Log.info("DEPLOY: Before restart")

Chef::Log.info("DEPLOY: Shutting down the current running")
script "shutdown" do
    interpreter "bash"
    user "root"
    cwd release_path
    code <<-EOH
        curl -XPOST "http://localhost:8080/shutdown" > /var/log/springbootext1/app.log 2>&1
    EOH
end

Chef::Log.info("DEPLOY: Running the deployed")
script "runjar" do
    interpreter "bash"
    user "root"
    cwd release_path
    code <<-EOH
        java -jar *.jar > /var/log/springbootext1/app.log 2>&1 &
    EOH
end