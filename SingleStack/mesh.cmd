mesh (lx=48,ly=40,lz=200,nx=48,ny=40,nz=200,nresolution=3,mapmaker,load="GAA.cgns",save="mesh.cgns") {
  region (material="Si",name="Si_Bulk",resolution=2)
  region (material="Si",name="deepsubstrate",resolution=2)
  region (material="Si",name="Si",resolution=0)
  region (material="SiO2",name="SiO2",resolution=2)
  region (material="Si3N4",name="SiN",resolution=2)
  region (material="Si3N4",name="inner",resolution=2)
  region (material="Si",name="SD",resolution=1)
  region (material="SiO2",name="gateoxide_SiO2",resolution=0)
  contact (name="gate_contact",type="this",region="gate")
  contact (name="body_contact",type="side",region="deepsubstrate",zmin)
  contact (name="sd_contact",type="this",region="MOL_Metal")
  selectcontact (input="sd_contact",output="source_contact",xmin=0)
  selectcontact (input="sd_contact",output="drain_contact",xmax=0)
  removecontact (name="sd_contact")
  contact (name="SD_Channel_interface",type="interface",first="Si",second="SD")
  doping (region="Si",type="gaussian",peakconc=1.0e26,baseconc=-1.0e22,diffusionlength=2,interface="SD_Channel_interface")
  removecontact (name="SD_Channel_interface")
  doping (region="Si_Bulk",type="uniform",conc=-1.0e22)
  doping (region="deepsubstrate",type="uniform",conc=-1.0e22)
  doping (region="SD",type="uniform",conc=1.0e26)
}





