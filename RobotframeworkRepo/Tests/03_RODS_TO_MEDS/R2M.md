- Tests

        Contain the Testcase Robot file based on below DB source,
		01_SRC_RODS- RODS
		02_SRC_MEDS- MEDS
		03_SRC_IMED- IMEDIDATA
		04_SRC_DALTON- DALTON
                05_SRC_SBJ- SUBJECTS

-Execution

         Command: robot -d Results/R2M_Results Tests/RODS_TO_MEDS
         use for debug: robot -d Results/R2M_Results -L DEBUG Tests/RODS_TO_MEDS
         use to run parallel execution: pabot -d Results/R2M_Results Tests/RODS_TO_MEDS
         use when no tags: robot -d Results/R2M_Results -r NONE -l NONE -o NONE  Tests/RODS_TO_MEDS
         use for tag: robot -d Results/R2M_Results -r NONE -l NONE -o NONE -v Default_Tag:Smoke  Tests/RODS_TO_MEDS
         
- Results
        
        Contains execution results in different formats like html and xml. Also generates a csv file that holds source/target counts and exceptions along with a study name used for comparison



