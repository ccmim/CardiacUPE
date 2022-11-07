client <- mlflow::mlflow_client(tracking_uri="/home/rodrigo/01_repos/CardiacCOMA/mlruns")

exp_info <- mlflow::mlflow_search_experiments(client=client)

runs = mlflow::mlflow_search_runs(client = client, experiment_ids="1", filter = "metrics.test_recon_loss < 1")