craft (name="GAA_BPR",lx=48,ly=40,lz=200,region="deepsubstrate",thickness=1,cgns="GAA.cgns") {
  region (name="Si_Bulk")
  region (name="SiGe")
  region (name="Si")
  depo (region="Si_Bulk",thickness=49)
  depo (region="SiGe",thickness=10)
  depo (region="Si",thickness=5)
  depo (region="SiGe",thickness=10)
  save (cgns="A_Stack.cgns")

  mask (name="mask_fin") {
    rectangle (x0=0,x1=48,y0=14,y1=26)
  }
  etch (mask="mask_fin",thickness=40)
  save (cgns="B_Fin.cgns")

  region (name="SiO2")
  depo (region="SiO2",thickness=50)
  cmp (position=80)

  model (name="model_SiO2") {
    select (region="SiO2")
  }
  etch (model="model_SiO2",thickness=30)
  save (cgns="C1_STI.cgns")

  region (name="a-Si")
  depo (region="a-Si",thickness=100)
  cmp (position=150)
  
  mask (name="mask_dummygate") {
    rectangle (x0=17,x1=31,y0=0,y1=40)
  }
  model (name="model_dummygate") {
    select (region="a-Si")
  }
  etch (mask="mask_dummygate",model="model_dummygate",thickness=100)
  save (cgns="C2_dummygate.cgns")
  
  depo (region="SiN",thickness=7)
  model (name="model_outer") {
    select (region="SiN")
  }
  etch (model="model_outer",thickness=7)
  save (cgns="C3_outer.cgns")

  model (name="model_SD_etch") {
    select (region="a-Si")
    select (region="SiN")
    select (region="Si")
    select (region="SiGe")
  }
  mask (name="mask_SD_etch") {
    rectangle (x0=10,x1=38,y0=0,y1=40)
  }
  etch (model="model_SD_etch",mask="mask_SD_etch",thickness=60)
  save (cgns="C4_SD_etch.cgns")

  model (name="model_cavity") {
    select (region="SiGe")
  }
  etch (model="model_cavity",iso,thickness=7)
  save (cgns="D_cavity.cgns")

  region (name="inner")
  depo (region="inner",thickness=20)
  model (name="model_inner") {
    select (region="inner")
  }
  etch (model="model_inner",thickness=135)
  save (cgns="E1_inner.cgns")

  region (name="SD")
  depo (region="SD",thickness=40)
  cmp (position=90)
  model (name="model_SD") {
    select (region="SD")
  }
  etch (model="model_SD",thickness=10)

  region (name="MOL_Metal")
  depo (region="MOL_Metal",thickness=20)
  cmp (position=90)

  model (name="model_a-Si") {
    select (region="a-Si")
  }
  etch (iso,model="model_a-Si",thickness=50)
  save (cgns="F_a-Si_release.cgns")

  model (name="model_SiGe") {
    select (region="SiGe")
  }
  etch (iso,model="model_SiGe",thickness=9)
  save (cgns="G_SiGe_release.cgns")

  region (name="gateoxide_SiO2")
  model (name="model_gox") {
    kernel (bandwidth=1)
    select (region="Si")
    select (region="Si_Bulk")
    select (region="gateoxide_SiO2")
  }
  depo (region="gateoxide_SiO2",kernel,model="model_gox",thickness=1)

  region (name="gate")
  depo (region="gate",thickness=20)
  cmp (position=90)
}
