from datetime import datetime


def Prepare_Draft_For_Study(study_name, draft_name, current_draft_path, create_new_study=True):
    print('*INFO* ==study_name==', study_name)
    print('*INFO* ==draft_name==', draft_name)
    print('*INFO* ==current_draft_path==', current_draft_path)
    print('*INFO* ==create_new_study==', create_new_study)
    try:
        now = datetime.now()
        date_to_append = now.strftime("%d%m%Y%H%M%S")
        if create_new_study:
            study_name = study_name+'_'+date_to_append
        draft_name = draft_name+'_'+date_to_append
        dummy_draft = current_draft_path+"Dummy/DummyDraft.xml"
        current_draft = current_draft_path+"Draft/"+draft_name+".xml"
        input = open(dummy_draft, "r")
        output = open(current_draft, "w")
        for line in input:
            if 'DummyDraftName' in line:
                output.write(line.replace('DummyDraftName', draft_name))
            elif 'DummyProjectName' in line:
                output.write(line.replace('DummyProjectName', study_name))
            else:
                output.write(line)
        input.close()
        output.close()
        return [True, study_name, current_draft, draft_name]
    except Exception as e:
        return [False, e]

