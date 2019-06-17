# Nextcloud Webcron on Docker

Run a Nextcloud HTTP Cron task from a Docker container.

Nextcloud servers require to run "Background jobs", and by default it uses AJAX, which executes them each time a request by a client is performance. The performance of this method is poor, so it's recommended to use Cron or Webcron to launch one task, at least, once each 15 minutes. ([Read more](https://docs.nextcloud.com/server/stable/admin_manual/configuration_server/background_jobs_configuration.html?highlight=webcron))

To keep the base Nextcloud container "clean", this Docker container launch a Webcron task periodically. A "Webcron task" is just a request to a Nextcloud endpoint (http://my-nextcloud-server/cron.php) that must be performed, at least, once each 15 minutes.

This container is based on the Alpine image, to keep it small. It execute a Shell script with a "while true" loop, which use Curl to request the Nextcloud Webcron endpoint and sleep for N seconds.

## Env Variables (settings)

YOU MUST SET the Nextcloud Webcron endpoint through an env variable on the Docker Container. Additionally, you can customize the Webcron frequency time (by default 600 seconds = once request each 10 minutes).

- **URL** - full URL to the Nextcloud cron.php endpoint
- **TIME** - frequency at which send the Cron update request (in seconds)
