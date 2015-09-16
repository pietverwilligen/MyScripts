#include <TROOT.h>
#include "TSystem.h"
#include "TStyle.h"

#include "TFile.h"
#include "TTree.h"
#include "TLeaf.h"

#include <stdio.h>
#include <iostream>
#include <iomanip>
#include <fstream>

bool ExtractNumberOfCountingIntervals(){

  // 1) Get TREE from ROOT file passed by arg
  TTree * tree = (TTree *) gFile->Get("tree");
  if(!tree) {
  std::cout<<"nEntries = 0"<<std::endl;
    return 0;
  }
  // TFile * file = new TFile("Histos_RB+2_far_run_234772_2015_2_19__20_0_32.root", "READ");
  // TTree * tree = (TTree*) file->Get("tree");
  // 2) Get Leaf 
  TLeaf * leaf = tree->FindLeaf("binsFull_");
  // 3) Get Number of Entries
  Int_t nEntries = leaf->GetNdata();
  // 4) Print Output
  std::cout<<"nEntries = "<<nEntries<<std::endl;
  return 1;

}
