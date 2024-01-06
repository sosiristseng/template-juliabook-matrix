#!/bin/sh
KERNEL_NAME=$(julia -e 'print("julia-1.",VERSION.minor)')

julia -e 'import IJulia; IJulia.installkernel("Julia", "--project=@.")'

jupyter nbconvert --to notebook --execute --inplace ${EXTRA_ARGS} \
    --ExecutePreprocessor.timeout=${TIMEOUT} \
    --ExecutePreprocessor.kernel_name=${KERNEL_NAME} \
    "docs/${NOTEBOOK}"
