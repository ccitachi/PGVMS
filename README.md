# PGVMS
Official implementation of "**PGVMS: A Prompt-Guided Unified Framework for Virtual Multiplex IHC Staining with Pathological Semantic Learning**" (TMI 2026) [[arxiv]](https://arxiv.org/abs/2602.23292) 

### 🐶Fuqiang Chen,  Ranran Zhang, Wanming Hu, Deboch Eyob Abera, Yue Peng, Boyun Zheng, Yiwen Sun, Jing Cai, Wenjian Qin 
<br>
<p align="center">
<img src="PSPStain.png" align="center" width="600" >
</p>
<br>

> Immunohistochemical (IHC) staining enables precise molecular profiling of protein expression, with over 200 clinically available antibody-based tests in modern pathology. However, comprehensive IHC analysis is frequently limited by insufficient tissue quantities in small biopsies. Therefore, virtual multiplex staining emerges as an innovative solution to digitally transform H&E images into multiple IHC representations, yet current methods still face three critical challenges: (1) inadequate semantic guidance for multi-staining, (2) inconsistent distribution of immunochemistry staining, and (3) spatial misalignment across different stain modalities. To overcome these limitations, we present a prompt-guided framework for virtual multiplex IHC staining using only uniplex training data (PGVMS). Our framework introduces three key innovations corresponding to each challenge: First, an adaptive prompt guidance mechanism employing a pathological visual language model dynamically adjusts staining prompts to resolve semantic guidance limitations (Challenge 1). Second, our protein-aware learning strategy (PALS) maintains precise protein expression patterns by direct quantification and constraint of protein distributions (Challenge 2). Third, the prototype-consistent learning strategy (PCLS) establishes cross-image semantic interaction to correct spatial misalignments (Challenge 3). Evaluated on two benchmark datasets, PGVMS demonstrates superior performance in pathological consistency. In general, PGVMS represents a paradigm shift from dedicated single-task models toward unified virtual staining systems.
 


  
## Requirements
```bash
conda env create -f environment.yml
```

install CONCH and dependencies in [CONCH](https://github.com/mahmoodlab/CONCH)
```bash
git clone https://github.com/mahmoodlab/CONCH.git
cd CONCH
pip install --upgrade pip
pip install -e .
```

## Dataset
 * Multi-IHC Stain Translation (MIST) dataset 
 * ImmunoHistoChemistry for Breast Cancer (IHC4BC) dataset

 More information and downloading links of the former two datasets can be found in [MIST](https://github.com/lifangda01/AdaptiveSupervisedPatchNCE) and [IHC4BC](https://ihc4bc.github.io/).


## Training from Scratch 
We use `experiments/PGVMS_launcher.py` to generate the command line arguments for training and testing. More details on the parameters used in training our models can be found in that launcher file.
* set the `dataroot` in `experiments/PGVMS_launcher.py` as your data path. 
* For MIST dataset or IHC4BC dataset, Mix the four IHC domains (HER2, ER, PR, Ki67) into one dataset. Use filename suffixes to indicate the domain: `_HER2`, `_ER`, `_PR`, `_Ki67` (e.g., `sample001_HER2.png`).
```bash
 dataset/
│
├── trainA/
    ├── HE
├── trainB/
    ├── IHC
├── valA/
├── valB/
```
💡**Important tips**💡
* Place pretrained models in `./pretrain/`:
  * **MIST**: put `MIST_ER_net_seg.pth`, `MIST_PR_net_seg.pth`, `MIST_HER2_net_seg.pth`, `MIST_Ki67_net_seg.pth`, etc. in `./pretrain/`
  * **IHC4BC**: put `IHC4BC_ER_net_seg.pth`, `IHC4BC_PR_net_seg.pth`, etc. in `./pretrain/`
  * Put the **CONCH** model folder in `./pretrain/` as well.
* These paths can be modified in `models/PGVMS_model.py`. The order must match the label order in `./data/aligned_dataset.py`. The default configuration is for MIST. 

```bash
python -m experiments --cmd train  --name "PGVMS" 
```
## Testing 
```bash
python -m experiments --cmd test  --name "PGVMS" 
```

## Checkpoint
* Place pretrained models in `./pretrain/`. The latest PGVMS weights (`./checkpoints/train/latest_net_G.pth`) are available at [Baidu Pan](https://pan.baidu.com/s/1cPZ2Kk6JtURmtQhtNxzyEQ?pwd=u6qo) (key: `u6qo`).

## Evaluation
* we use the Image-J to calculate the optical density value.

## Acknowledgement
This repo is built upon [Contrastive Unpaired Translation (CUT)](https://github.com/taesungp/contrastive-unpaired-translation), [Adaptive Supervised PatchNCE Loss (ASP)](https://github.com/lifangda01/AdaptiveSupervisedPatchNCE) and [CONCH](https://github.com/mahmoodlab/CONCH)
