page 50955 "New File List"
{
    // version TL2.0

    CardPageID = "Registry File Card";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Registry File";
    //SourceTableView = WHERE(Created = filter('No'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("RegFile Status"; Rec."RegFile Status")
                {
                    Caption = 'File Status';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

