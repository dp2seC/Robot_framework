- Tests

        Contain the Testcase Robot file based on below DB source,
		RaveToRods- RAVE


-Execution

        Command: robot -d Results/R2R_Results Tests/02_RAVE_TO_RODS
        use for debug: robot -d Results/R2R_Results -L DEBUG Tests/02_RAVE_TO_RODS
        use to run parallel: pabot -d Results/R2R_Results Tests/RAVE_TO_RODS
        use when no tags: robot -d Results/R2R_Results -r NONE -l NONE -o NONE  Tests/RAVE_TO_RODS
        use for tag: robot -d Results/R2R_Results -r NONE -l NONE -o NONE -v Default_Tag:Smoke  Tests/RAVE_TO_RODS
         
- Results
        
        Contains execution results in different formats like html and xml. Also generates a csv file that holds source/target counts and exceptions along with a study name used for comparison
