page 50800 "Restr. Tender List- Proc. Mgr"
{
    // version TL2.0

    Caption = 'Restricted Tender List - Procurement Manager';
    CardPageID = "Restricted Tender Card";
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Procurement Request";
    SourceTableView = WHERE("Procurement Option" = FILTER('Restricted Tender'),
                            "Process Status" = FILTER('Procurement Manager' | CEO),
                            Status = FILTER(New | 'Pending Approval'));

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
                field("Process Status"; Rec."Process Status")
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
    trigger OnOpenPage()
    begin
        ProcurementSetup.Get();
        UserSetup.Get(UserId);
        IF Rec.Status = Rec.Status::New then begin
            if UserSetup."User ID" <> ProcurementSetup."Procurement Manager" then begin
                //Error(ProcMgrErrorTxt);
            end;
        end;
    end;

    var
        ProcurementSetup: Record "Procurement Setup";
        UserSetup: Record "User Setup";
        CEOErrorTxt: Label 'Only the CEO can open this page';
        ProcMgrErrorTxt: Label 'Only the Procurement Manager can open this page';
}

