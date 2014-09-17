---
layout: post
title: Nginx Stub Status Explanation
category: Nginx
---
# Nginx Stub Status Explanation
## Make sure HttpStubStatusModule is compiled
Locate the nginx executable and use below command to verify that HttpStubStatusModule is compiled and available to you:

```
nginx -V 2>&1 | grep -o http_stub_status_module
```

<div class='alert alert-info alert-tip'>
<h3>No Nginx?</h3>
<p>Do you have problem with finding your nginx executable? If nginx is running already, do this:</p>
<pre>
<code>ps aux | grep [n]ginx</code>
</pre>
<p>The output will indicate the nginx executable path. And instead of just typing nginx in above command you should use the fullpath. (e.g. <code>/opt/etc/nginx -V 2>&1 | grep -o http_stub_status_module</code>).</p>
</div>

You should get an output like this:

```shell
with-http_stub_status_module
```

<div class='alert alert-danger'>
If you dont see any output it means it is not compiled!
</div>

## Monitoring address
Open your config file. You can find it's path by:

```shell
nginx -V 2>&1 | grep -o 'conf-path=[^ ]*'
```

Now inside one of your `server { ... }` tags, add below lines (it can be any of your server tags, more commonly the one listening to port 80 or 8080):

```
location /status {
  stub_status on;
  access_log   off;
  allow 127.0.0.1;
  deny all;
}
```

Now reload your nginx with the new configuration by following command:

```shell
sudo nginx -s reload
```

<div class='alert alert-info alert-tip'>
<h3>No result?</h3>
<p>Can't load it? make sure you are using fullpath to your nginx executable and you have the right permissions.</p>
</div>

## Check the stats
Now open a web browser and access it at **http://YOUR_IP_OR_ADDRESS/status**. or use wget to read it from terminal:

```shell
wget http://127.0.0.1/status
```

<div class='alert alert-info alert-tip'>
<h3>No result?</h3>
<p>Which port your server tag is listening to? 80, 8080 or something else? If it is port 8080 do this <code>wget http://127.0.0.1:8080/status</code>.</p>
</div>

You should see a result like this in your browser (or if you have used wget, in the downloaded file `cat status`):

```
Active connections: 20
server accepts handled requests
 20428 20428 51058 
 Reading: 0 Writing: 10 Waiting: 10
```

- **Active connections** The current number of active client connections including Waiting connections. A single Client can have multiple connections with your server.
- **Accepts** The total number of accepted client connections.
- **Handled** The total number of handled connections. Generally, the parameter value is the same as accepts unless some resource limits have been reached.
- **Requests** The total number of client requests. Dividing this number by **Handled** will give you number of requests per connection handled by Nginx (51058/20428 = 2.49 requests per connection).
- **Reading** The current number of connections where nginx is reading the request header.
- **Writing** The current number of connections where nginx is writing the response back to the client (This includes: nginx reads request body, processes request, or writes response to a client).
- **Waiting** The current number of idle client connections waiting for a request. This is **Active - (Reading + Writing)**. This is keep alive connections and having a high **Waiting** number is not a bad thing. It means how many connections are still open and waiting for either a new request, or the keepalive expiration. You can change it in your nginx.conf file by modifying `keepalive_timeout`.

