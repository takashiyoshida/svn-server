# README

A Docker container providing a Subversion (SVN) server, based on CentOS 8. You can access the server via WebDAV protocol (`http://`).

## Running Commands

To run the image, you can use the following command:

```
docker run -d --name svn-server -p 80:80 takashiyoshida:svn-server
```

## Configuration

You need to add your own username and password in order to access the Subversion server via WebDAV protocol. For this, you can use the following command from your host machine.

```
docker exec -t svn-server htpasswd -b -cm /etc/subversion/passwd <username> <password>
```

To load an existing SVN dump file onto the Subversion server, you can start the container like this:

```
docker run -d --name svn-server -p 80:80 -v <directory to the SVN dump file>:/data takashiyoshida:svn-server
```

And load the dump file like this:

```
docker exec -it svn-server bash
```

```
svn admin load /home/svn/repos < /data/<SVN dump file>
```

If you need to create a separate project root directory, you can do something like this:

```
svn mkdir -m "Add project root directory" http://localhost/svn/repos/<project-root-directory>
svn admin load --parent-dir <project-root-directory> /home/svn/repos < /data/<SVN dump file>
```
