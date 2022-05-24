# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

ARG repo
ARG arch
FROM ${repo}:${arch}-conda

# install the required conda packages into the test environment
COPY ci/conda_env_cpp.yml \
     ci/conda_env_gandiva.yml \
     /arrow/ci/
RUN conda install \
        --file arrow/ci/conda_env_cpp.yml \
        --file arrow/ci/conda_env_gandiva.yml \
        compilers \
        doxygen \
        gdb \
        valgrind && \
    conda clean --all

ENV ARROW_BUILD_TESTS=ON \
    ARROW_DATASET=ON \
    ARROW_DEPENDENCY_SOURCE=CONDA \
    ARROW_FLIGHT=ON \
    ARROW_GANDIVA=ON \
    ARROW_HOME=$CONDA_PREFIX \
    ARROW_ORC=ON \
    ARROW_PARQUET=ON \
    ARROW_PLASMA=ON \
    ARROW_S3=ON \
    ARROW_USE_CCACHE=ON \
    ARROW_WITH_BROTLI=ON \
    ARROW_WITH_BZ2=ON \
    ARROW_WITH_LZ4=ON \
    ARROW_WITH_SNAPPY=ON \
    ARROW_WITH_ZLIB=ON \
    ARROW_WITH_ZSTD=ON \
    PARQUET_BUILD_EXAMPLES=ON \
    PARQUET_BUILD_EXECUTABLES=ON \
    PARQUET_HOME=$CONDA_PREFIX
