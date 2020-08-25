use Mix.Config

config :leaply, LeaplyWeb.Endpoint,
  server: true, # Without this line, your app will not start the web server!
  load_from_system_env: true, # Needed for Phoenix 1.3. Doesn't hurt for other versions
  http: [port: {:system, "PORT"}], # Needed for Phoenix 1.2 and 1.4. Doesn't hurt for 1.3.
  secret_key_base: "${SECRET_KEY_BASE}",
  url: [host: "${APP_NAME}.gigalixirapp.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  version: Mix.Project.config[:version] # To bust cache during hot upgrades

config :leaply, Leaply.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "", # Works around a bug in older versions of ecto. Doesn't hurt for other versions.
  ssl: true,
  pool_size: 2 # Free tier db only allows 4 connections. Rolling deploys need pool_size*(n+1) connections where n is the number of app replicas.

# Configure libcluster for node clustering on Kubernetes in production
# See: https://gigalixir.readthedocs.io/en/latest/cluster.html#cluster-your-nodes
config :libcluster,
  topologies: [
    k8s_example: [
      strategy: Cluster.Strategy.Kubernetes,
      config: [
        kubernetes_selector: "${LIBCLUSTER_KUBERNETES_SELECTOR}",
        kubernetes_node_basename: "${LIBCLUSTER_KUBERNETES_NODE_BASENAME}"]]]

# Do not print debug messages in production
config :logger, level: :info
