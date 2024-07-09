# rseuratjupyter-docker
A Docker image with Jupyter Notebook, R kernel, and Bioconductor packages along with ScRna tools 


Features

- Jupyter Notebook with R kernel (4.4.0)
- Bioinformatics packages:
  - `multtest`, `S4Vectors`, `SummarizedExperiment`, `SingleCellExperiment`, `MAST`, `DESeq2`, `BiocGenerics`, `GenomicRanges`, `IRanges`, `rtracklayer`, `monocle`, `Biobase`, `limma`, `glmGamPoi`, `SingleR`, `scRepertoire`, `cowplot`, `singlecellTK`,`rhdf5`,`celldex`, `monocle3`,`SeuratWrappers` , `ggrepel`, `ggplotify`,`gtools`,`beanplot`,`mixtools`,`pheatmap`,`zoo`,`squash`,`singleseqgset`,`CONICSmat`,`cytotrace2`,`biomart`,`ComplexHeatmap`
- Pre-installed `tidyverse` package for data science tasks
- TensorFlow installed via Python
- Seurat - for Singlecell Rna analysis workflow.


Will be updated constantly on need-basis.

# How to use the Docker Image

1. Pull the Docker image:

- docker pull cnithin7/rseuratjupyter

2. Run the container and map the ports:

- docker run -p 8888:8888 -v $(pwd):/workspace cnithin7/rseuratjupyter

After running the above command, you will see an output with a URL to run jupyter notebook with R kernel. You can now start using the pre-installed packages.



