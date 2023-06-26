function Mesh = ReadPolygonMeshFromVTKFile(FilePathAndName)
Mesh = ReadMeshFromVTKFile(FilePathAndName);
% creating new attribute of Mesh Face with same feature as Element
Mesh.Face=Mesh.Element;
% deleting the previous attribute Element
Mesh=rmfield(Mesh, 'Element');

