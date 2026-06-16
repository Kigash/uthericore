page 50603 "Payment Voucher Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Payment Line";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Account Type"; Rec."Account Type")
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
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }


                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update()
                    end;

                }
                field("Charge Withholding Tax"; Rec."Charge Withholding Tax")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Validate("W/Tax Amount");

                    end;
                }
                field("W/Tax Amount"; Rec."W/Tax Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update()
                    end;
                }
                field("VAT Business Posting Group"; Rec."VAT Business Posting Group")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Validate("VAT Amount");

                    end;
                }
                field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Validate("VAT Amount");

                    end;
                }

                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update()
                    end;
                }
                field("Applies to Doc Type"; Rec."Applies to Doc Type")
                {
                    ApplicationArea = All;
                }
                field("Applies to Doc. No"; Rec."Applies to Doc. No")
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
            action("Suggest Lines")
            {
                Image = SuggestLines;

                trigger OnAction();
                begin
                    CashManagement.SuggestPaymentLines(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin

    end;

    var
        CashManagement: Codeunit "Cash Management";

}

