The correlation algorithm steps:

1. Script Coordinates.m 
    reads Picture_parameters.xlsx
    calles ScalePics.m function
    writes Scaling_parameters.xlsx
    reads raman data excel files
    calls nCTPoints.m function
        function writes nCT_coordinates.xlsx
        function writes nCT_center.xlsx

2. Script PositionCorrelation.m
    reads nCT_coordinates.xlsx
    reads raman data excel files
    calls FindSegments.m function
    writes match_(pillarcolor).xlsx
    calls RotMatangle.m function
            RotMatangle.m function calls 
            Rx.m Ry.m Rz.m 

RotMatangle.m function is the one that transforms 
the angle systems. Details inside
