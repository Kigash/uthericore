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
                var
                    PayoutChargeRange: Record "Payout Charge Range";
                begin
                    PayoutHeader.GET(Rec."Document No.");
                    PayoutHeader.TESTFIELD(Posted, false);

                    if PayoutHeader."Charge Calculation Method" = PayoutHeader."Charge Calculation Method"::"Flat Amount" then
                        PayoutHeader.TESTFIELD("Flat Charge Amount");

                    if PayoutHeader."Charge Calculation Method" = PayoutHeader."Charge Calculation Method"::Range then begin
                        PayoutChargeRange.Reset();
                        PayoutChargeRange.SETRANGE("Document No.", PayoutHeader."No.");
                        IF PayoutChargeRange.ISEMPTY THEN
                            ERROR('You must specify at least one charge range for the selected charge calculation method.');
                    end;

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