ARG tfversion=latest-gpu-py3
FROM tensorflow/tensorflow:$tfversion
WORKDIR /tf
RUN apt-get update && apt-get install -y vim wget tmux
# Installing nodejs required for jupyterlab plugins
RUN wget https://deb.nodesource.com/setup_12.x && chmod +x setup_12.x && bash setup_12.x && apt-get install -y nodejs 
# Installing required packages (some are already present in tensorflow distribution)
RUN pip install --upgrade request scikit-image scikit-learn pandas seaborn tensorflow-probability SimpleITK jupyterlab
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
# Installing tensorboard for jupyterlab
RUN pip install --upgrade jupyter-tensorboard && jupyter labextension install jupyterlab_tensorboard
# This is to fix a bug in tensorflow docker not finding nvidia drivers:
RUN ldconfig
CMD bash
