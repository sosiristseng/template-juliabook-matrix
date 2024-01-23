#!/bin/sh
jupyter nbconvert --to notebook --execute --inplace ${EXTRA_ARGS} \
    --ExecutePreprocessor.timeout=-1 \
    --ExecutePreprocessor.kernel_name=$(julia -e 'print("julia-1.",VERSION.minor)') \
    "docs/${NOTEBOOK}"
