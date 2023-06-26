%%
load('ShapeData.mat') %729 shapes
load('StressData.mat') %stress from FEA
%% show ground truth stress on 3D and 2D meshes of the 729 shapes
for ShapeIndex=1:729
    S11=StressData(1,:,ShapeIndex);
    S22=StressData(2,:,ShapeIndex);
    S12=StressData(4,:,ShapeIndex);
    Von=sqrt(S11.*S11+S22.*S22-S11.*S22+3*S12.*S12);
    Mesh3D = ReadPolygonMeshFromVTKFile('TemplateMesh3D.vtk');
    Mesh3D.Point=reshape(ShapeData(:,ShapeIndex), [3, 5000]);
    Mesh3D.PointData(1).Name='S11';
    Mesh3D.PointData(1).Data=S11(:);
    Mesh3D.PointData(2).Name='S22';
    Mesh3D.PointData(2).Data=S22(:);
    Mesh3D.PointData(3).Name='S12';
    Mesh3D.PointData(3).Data=S12(:);
    Mesh3D.PointData(4).Name='Von';
    Mesh3D.PointData(4).Data=Von(:);
    WritePolygonMeshAsVTKFile(Mesh3D, ['result/' num2str(ShapeIndex) '_Aorta_stress_FEA.vtk'])
    % show ground truth stress on 2D mesh
    S11=StressData(1,:,ShapeIndex);
    S22=StressData(2,:,ShapeIndex);
    S12=StressData(4,:,ShapeIndex);
    S11=reshape(S11, [50, 100]);
    S11(end+1,:)=S11(1,:);
    S22=reshape(S22, [50, 100]);
    S22(end+1,:)=S22(1,:);
    S12=reshape(S12, [50, 100]);
    S12(end+1,:)=S12(-1,:);
    Von=sqrt(S11.*S11+S22.*S22-S11.*S22+3*S12.*S12);
    Mesh2D = ReadPolygonMeshFromVTKFile('TemplateMesh2D.vtk');
    Mesh2D.PointData(1).Name='S11';
    Mesh2D.PointData(1).Data=S11(:);
    Mesh2D.PointData(2).Name='S22';
    Mesh2D.PointData(2).Data=S22(:);
    Mesh2D.PointData(3).Name='S12';
    Mesh2D.PointData(3).Data=S12(:);
    Mesh2D.PointData(4).Name='Von';
    Mesh2D.PointData(4).Data=Von(:);
    WritePolygonMeshAsVTKFile(Mesh2D, ['result/' num2str(ShapeIndex) '_StressGrid_FEA.vtk'])
end