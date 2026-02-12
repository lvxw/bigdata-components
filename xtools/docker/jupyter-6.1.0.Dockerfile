FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

ARG JUPYTER_VERSION="6.1.0"

RUN mkdir -p /root/.jupyter /data/jupyter-notebook

RUN pip install jupyter && \
  pip install --upgrade notebook==6.1.0  && \
  pip install jupyter_contrib_nbextensions  && \
  jupyter contrib nbextension install && \
  pip install jupyter_nbextensions_configurator  && \
  jupyter nbextensions_configurator enable && \
  pip install numpy scipy matplotlib scikit-learn

RUN pip install  tensorflow

COPY /dependency/jupyter-${JUPYTER_VERSION}/jupyter_notebook_config.py /root/.jupyter/

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo "jupyter notebook --allow-root" >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]