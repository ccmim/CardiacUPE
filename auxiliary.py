import pickle as pkl
import os
import torch

HOME = os.environ["HOME"]
CARDIAC_GWAS_REPO = f"{HOME}/01_repos/CardiacGWAS"
CARDIAC_COMA_REPO = f"{HOME}/01_repos/CardiacCOMA"
GWAS_REPO = f"{HOME}/01_repos/GWAS_pipeline"


def get_model_pretrained_weights(exp_id, run_id):
    
    # run_info = runs_df.loc[experiment_id, run_id].to_dict()
    chkpt_dir = f"{CARDIAC_COMA_REPO}/mlruns/{exp_id}/{run_id}/checkpoints"
    if not os.path.exists(chkpt_dir):
        chkpt_dir = f"{CARDIAC_COMA_REPO}/mlruns/{exp_id}/{run_id}/artifacts/restored_model_checkpoint"
    
    chkpt_file = os.path.join(chkpt_dir, os.listdir(chkpt_dir)[0])
    
    model_pretrained_weights = torch.load(chkpt_file, map_location=torch.device('cpu'))["state_dict"]
    
    # Remove "model." prefix from state_dict's keys.
    _model_pretrained_weights = {k.replace("model.", ""): v for k, v in model_pretrained_weights.items()}

    return _model_pretrained_weights


def load_data(a):

    global meshes, procrustes_transforms
    print("Loading mesh data...")
    meshes = pkl.load(open(f"{CARDIAC_COMA_REPO}/data/cardio/LV_meshes_at_ED_35k.pkl", "rb"))
    print("Mesh data loaded successfully.")
    
    print("Loading Procrustes transforms...")
    procrustes_transforms = pkl.load(open(f"{CARDIAC_COMA_REPO}/data/cardio/procrustes_transforms_35k.pkl", "rb"))
    print("Procrustes transform loaded successfully.")