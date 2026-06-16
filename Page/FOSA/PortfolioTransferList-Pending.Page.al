page 55092 "Portfolio Transfer-Pending"
{
    // version MC2.0

    Caption = 'Pending Portfolio Transfers';
    CardPageID = "Portfolio Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "Portfolio Transfer";
    SourceTableView = WHERE(Status = FILTER("Pending Approval"));

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
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Source Branch Code"; Rec."Source Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Source Branch Name"; Rec."Source Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Source Loan Officer ID"; Rec."Source Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
        Variant2 := Rec;
        // MicroCreditManagement.ShowApprovalEntries(Variant2, 1);
        Rec.COPY(Variant2);
    end;

    var
        Variant2: Variant;
}

