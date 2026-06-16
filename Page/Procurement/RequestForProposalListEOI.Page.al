page 50780 "Request For Proposal List- EOI"
{
    // version TL2.0

    Caption = 'Request For Proposal List - Pending Proposal';
    CardPageID = "Request For Proposal Card";
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Procurement Request";
    SourceTableView = WHERE("Procurement Option" = FILTER('Request For Proposal'),
                            "Process Status" = FILTER('EOI Invitation' | Proposal | 'Pending Opening'));

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No."; Rec."Procurement Plan No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Assigned User"; Rec."Assigned User")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
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

