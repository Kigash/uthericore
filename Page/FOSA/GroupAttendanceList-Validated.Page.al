page 55029 "Grp Attendance List-Validated"
{
    // version MC2.0

    Caption = 'Validated Group Attendance';
    CardPageID = "Group Attendance";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Group Attendance Header";
    SourceTableView = WHERE(Status = FILTER(Validated));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = All;
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = All;
                }
                field("Current Meeting Date"; Rec."Current Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Meeting Venue"; Rec."Meeting Venue")
                {
                    ApplicationArea = All;
                }
                field("Loan Officer ID"; Rec."Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        ERROR(Error000);
    end;

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(FALSE);
    end;

    var
        //MicroCreditManagement: Codeunit "55002";
        Member: Record "Member";
        Error000: Label 'You cannot delete this record!';
}

