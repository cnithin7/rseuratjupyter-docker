# Base image from Bioconductor
FROM bioconductor/bioconductor_docker:devel

# Update apt-get and install TensorFlow
RUN apt-get update \
    && pip install tensorflow \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install required Bioconductor packages
RUN R -e "BiocManager::install(c('multtest', 'S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'BiocGenerics', 'GenomicRanges', 'IRanges', 'rtracklayer', 'monocle', 'Biobase', 'limma', 'glmGamPoi', 'SingleR','scRepertoire','cowplot'))"

# Install Jupyter and R kernel for Jupyter
RUN pip install jupyter \
    && R -e "install.packages('IRkernel', repos='http://cran.us.r-project.org')" \
    && R -e "IRkernel::installspec(user = FALSE)"

# Install Seurat from GitHub
RUN R -e 'remotes::install_github("satijalab/seurat", ref="seurat5", quiet=TRUE)'

# Install tidyverse
RUN R -e 'install.packages("tidyverse", repos="http://cran.us.r-project.org")'

# Create a directory for the workspace
WORKDIR /workspace

# Expose port for Jupyter Notebook
EXPOSE 8888

# Start Jupyter Notebook with R kernel
CMD ["sh", "-c", "jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]



