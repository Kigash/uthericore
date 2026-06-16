page 50281 "Payout Subform"
{
    // version TL2.0

    AutoSplitKey = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Payout Line";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    ApplicationArea = All;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Duty Amount"; Rec."Excise Duty Amount")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
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
            action("Import Payout File")
            {
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PayoutHeader.GET(Rec."Document No.");
                    PayoutHeader.TESTFIELD(Status, PayoutHeader.Status::New);

                    CLEAR(ImportPayoutFile);
                    ImportPayoutFile.SetPayoutNo(Rec."Document No.");
                    ImportPayoutFile.RUN;
                end;
            }
        }
    }

    var
        ImportPayoutFile: XMLport "Import Payout File";
        PayoutHeader: Record "Payout Header";
}

