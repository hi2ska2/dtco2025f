thing (type="device",name="pd") {
  device (type="3d",areafactor=1.0) {
    load (cgns="mesh.cgns",dbpath="YOUR DB PATH")
    electrode (name="gate_contact",workfunction=4.4)
  }
}

property (thing="pd",model="effectiveintrinsicdensity",oldslotboom)

thing (type="lumped",name="vg") { lumped (type="v",value=0.0) }
thing (type="lumped",name="vd") { lumped (type="v",value=0.0) }

thing (type="circuit",name="circuit") {
  circuit {
    node (thing="gnd",name="GND")
    node (thing="pd",contact="gate_contact",name="GATE")
    node (thing="pd",contact="drain_contact",name="DRAIN")
    node (thing="pd",contact="source_contact",name="GND")
    node (thing="pd",contact="body_contact",name="GND")

    node (thing="vg",contact="0",name="GND")
    node (thing="vg",contact="1",name="GATE")
    node (thing="vd",contact="0",name="GND")
    node (thing="vd",contact="1",name="DRAIN")
  }
}

law (name="eqlaw") {
  equation (type="poisson",thing="pd")
}

solve (law="eqlaw",iteration=10,initialstep=1,
       matrixsolver="pardiso",threads=1,
       plot,plotprefix="eq_pd",cgns)

law (name="dclaw",iteration=20) {
  equation (type="poisson",thing="pd")
  equation (type="econtinuity",thing="pd")
  equation (type="hcontinuity",thing="pd")
  equation (type="contact",thing="pd")

  equation (type="virlc",thing="vg")
  equation (type="virlc",thing="vd")

  equation (type="kirchhoff",thing="circuit")
}

book (name="vgsweep_linear",csv="dc_vg_pd_linear.csv") {
  event (thing="pd",contact="source_contact")
  event (thing="pd",contact="drain_contact")
  event (thing="pd",contact="gate_contact")
}

book (name="vgsweep_saturation",csv="dc_vg_pd_saturation_const.csv") {
  event (thing="pd",contact="source_contact")
  event (thing="pd",contact="drain_contact")
  event (thing="pd",contact="gate_contact")
}

solve (law="dclaw",initialstep=0.5,maxstep=0.5,minstep=1e-6,dozero,
       matrixsolver="pardiso",threads=1,plot,plotprefix="dc",cgns) {
  goal (thing="vd",quantity="voltage",value=0.7)
}

solve (law="dclaw",initialstep=0.02,maxstep=0.02,minstep=1e-6,dozero,book="vgsweep_saturation",
       matrixsolver="pardiso",threads=1,plot,plotprefix="dc",cgns) {
  goal (thing="vg",quantity="voltage",value=0.7)
}


