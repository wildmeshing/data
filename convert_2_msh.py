import meshio as mio
import glob
import igl
import os

for ext in [".obj", ".ply", ".stl"]:
    for file in glob.glob(f"./**/*{ext}", recursive=True):
        if ext == ".obj":
            v, f = igl.read_triangle_mesh(file)
            m = mio.Mesh(v, [("triangle", f)])
        else:
            m = mio.read(file)

        m.write(
            file.replace(ext, ".msh"),
            file_format="gmsh",
            binary=True
        )
