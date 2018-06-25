FROM continuumio/anaconda3
MAINTAINER Justin Buchanan <justbuchanan@gmail.com>

RUN apt install -y freecad libglu1-mesa python-pip
RUN conda install -c pythonocc -c oce -c conda-forge -c dlr-sc -c CadQuery cadquery-occ
RUN pip2 install cqparts

RUN mkdir /examples
WORKDIR /examples
RUN git clone https://github.com/fragmuffin/cqparts
RUN git clone https://github.com/zignig/cqparts-bucket

# Render a test file to ensure that the basics are working
COPY test.py .
RUN python2 test.py out.stl
