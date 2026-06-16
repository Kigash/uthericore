page 50771 "Evaluated RFQ List - Approved"
{
    // version TL2.0

    Caption = 'Request For Quotation List - CEO';
    CardPageID = "Request For Quotation Card";
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Procurement Request";
    SourceTableView = WHERE("Procurement Option" = FILTER('Request For Quotation'),
                            "LPO Generated" = FILTER(false),
                            "Process Status" = FILTER("Procurement Manager" | CEO),
                            Status = FILTER(Released));

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
    trigger OnOpenPage()
    begin
        ProcurementSetup.Get();
        UserSetup.Get(UserId);
        if UserSetup."User ID" <> ProcurementSetup."CEO's Account" then begin
            Error(CEOErrorTxt);
        end;
    end;

    var
        ProcurementSetup: Record "Procurement Setup";
        UserSetup: Record "User Setup";
        CEOErrorTxt: Label 'You are not Set up as the CEO';
}

