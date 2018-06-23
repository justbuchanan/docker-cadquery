FROM continuumio/anaconda3
MAINTAINER Justin Buchanan <justbuchanan@gmail.com>

RUN conda install -c pythonocc -c oce -c conda-forge -c dlr-sc -c CadQuery cadquery-occ

RUN apt install -y freecad libglu1-mesa
# python 2
RUN apt install -y python-pip

RUN pip2 install cqparts

RUN mkdir /examples
WORKDIR /examples

RUN git clone https://github.com/fragmuffin/cqparts
RUN git clone https://github.com/zignig/cqparts-bucket

COPY render.py .
RUN python2 render.py out.stl
