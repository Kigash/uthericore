page 50971 "File Movement Request List"
{
    // version TL2.0

    Caption = 'InterBranch File Transfer';
    CardPageID = "File Movement Request Card";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "File Movement";
    SourceTableView = WHERE(Status = filter('New'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Movement ID"; Rec."File Movement ID")
                {
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Cabinet No."; Rec."Cabinet No.")
                {
                    ApplicationArea = All;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                }
                field("Request Remarks"; Rec."Request Remarks")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field("Released To"; Rec."Released To")
                {
                    ApplicationArea = All;
                }
                field("Carried By"; Rec."Carried By")
                {
                    ApplicationArea = All;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //user.GET(USERID);
    end;

    var
        user: Record "User Setup";
        RegistryFiles: Record "Registry File";
}

