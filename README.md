# Apache Sqoop using Docker. 🐳

A Docker image to play around with [Apache Sqoop](https://sqoop.apache.org) with Hadoop configured in a [Pseudo Distributed Mode](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html) (single cluster mode).

### Below are the steps to use this image on [Play with Docker](https://labs.play-with-docker.com).

1. First of all, create an account on [Docker Hub](https://hub.docker.com/signup).
2. Login to [Play with Docker](https://labs.play-with-docker.com) using the Docker Hub account you just created.
3. You should see a green "Start" button, click on it to start a session.
4. Create an instance by clicking on "+ Add new instance" in the left pane, to create a VM.
5. A new terminal should show up in the right pane. Here, we need to pull the Docker image from _Github Container Registry (GHCR)_.
   To do so, execute:

```bash
docker pull ghcr.io/kasipavankumar/sqoop-docker:latest
```

6. After the image has been pulled into the VM, we need to start a new container & switch into it's terminal (mostly bash).
   To do so, execute:

```bash
docker run -it ghcr.io/kasipavankumar/sqoop-docker:latest
```

_At this stage, the image will be booting up by executing all the required for running Sqoop._

**From now on, you will be inside container's bash (terminal).** 🚀

To verify the working, try the following command:

```bash
sqoop import \
    --connect jdbc:mysql://localhost/employees \
    --table employees \
    --username bda \
    --password 123456
```

This should import all the employees data into Hadoop file system which can be verfied by:

```bash
hadoop fs -ls /user/root/employees
```

which should list around 5 files & using `cat` on any one of them should show few employees records. 🎉

<hr />

<div align="center">

[![Deploy Docker image](https://github.com/kasipavankumar/sqoop-docker/actions/workflows/deploy.yml/badge.svg)](https://github.com/kasipavankumar/sqoop-docker/actions/workflows/deploy.yml)

</div>

<hr />

<div align="center">

```txt
D. Kasi Pavan Kumar (c) 2021
```

</div>
