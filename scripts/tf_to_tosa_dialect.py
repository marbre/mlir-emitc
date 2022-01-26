# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import argparse

from tensorflow.python import pywrap_mlir  # pylint: disable=no-name-in-module


def convert(model_path: str, output_path: str):
    pass_pipeline = pass_pipeline = ",".join([
        "inline", "canonicalize", "cse", "builtin.func(affine-loop-fusion)",
        "builtin.func(affine-scalrep)", "builtin.func(tosa-fuse-bias-tf)",
        "builtin.func(tosa-legalize-tf)", "builtin.func(tosa-infer-shapes)",
        "builtin.func(tosa-make-broadcastable)", "inline", "symbol-dce"
    ])
    with open(model_path) as file:
        mlir = file.read()

    with open(output_path, "w") as file:
        file.write(
            pywrap_mlir.experimental_run_pass_pipeline(mlir, pass_pipeline,
                                                       True))


def main():
    parser = argparse.ArgumentParser(
        description="Convert model in tf dialect to tosa dialect")
    parser.add_argument("model_path",
                        metavar="model-path",
                        help="Path to tf mlir model")
    parser.add_argument("output_path",
                        metavar="output-path",
                        help="Output path")
    args = parser.parse_args()

    convert(args.model_path, args.output_path)


if __name__ == "__main__":
    main()
