page 55093 "Portfolio Transfers-Approved"
{
    // version MC2.0

    Caption = 'Approved Portfolio Transfers';
    CardPageID = "Portfolio Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "Portfolio Transfer";
    SourceTableView = WHERE(Status = FILTER(Approved));

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
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
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
        // MicroCreditManagement.ShowApprovalEntries(Variant2,2);
        Rec.COPY(Variant2);
    end;

    var
        //MicroCreditManagement: Codeunit "55001";
        Variant2: Variant;
}

