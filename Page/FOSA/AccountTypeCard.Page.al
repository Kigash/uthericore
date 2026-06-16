page 50015 "Account Type Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Account Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                    ApplicationArea = All;
                }
                field("Dormancy Period"; Rec."Dormancy Period")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee"; Rec."Ledger Fee")
                {
                    ApplicationArea = All;
                }
                field("Can Guarantee Loan"; Rec."Can Guarantee Loan")
                {
                    ApplicationArea = All;
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                group(SubType)
                {
                    Visible = Rec.Type = 1;
                    Caption = '';
                    field("Sub Type"; Rec."Sub Type")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Applies to Member Category"; Rec."Applies to Member Category")
                {
                    ApplicationArea = All;
                }
                field("Applies to Age Class"; Rec."Applies to Age Class")
                {
                    ApplicationArea = All;
                }
                field("Allow Withdrawal"; Rec."Allow Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Allow Deposit"; Rec."Allow Deposit")
                {
                    ApplicationArea = All;
                }

                field("Earns Interest"; Rec."Earns Interest")
                {
                    ApplicationArea = All;
                }
                group(EarnInterest)
                {
                    Caption = '';
                    Visible = Rec."Earns Interest" = TRUE;
                    field("Earn Commission on Interest"; Rec."Earns Commission on Interest")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Earns Dividend"; Rec."Earns Dividend")
                {
                    ApplicationArea = All;
                }

                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }

                group(Close)
                {
                    Caption = '';
                    Visible = CloseAccount;
                    field("Closing Fees"; Rec."Closing Fees")
                    {
                        ApplicationArea = All;
                    }
                    field("Transfer Account After Closure"; Rec."Transfer Account After Closure")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Maximum No. of Withdrawal"; Rec."Maximum No. of Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Maximum Withdrawal Amount"; Rec."Maximum Withdrawal Amount")
                {
                    ApplicationArea = All;
                }
                field("Maximum Deposit Amount"; Rec."Maximum Deposit Amount")
                {
                    ApplicationArea = All;
                }
                field("Allow Multiple Accounts"; Rec."Allow Multiple Accounts")
                {
                    ApplicationArea = All;
                }
                field("Allow Cheque Deposit"; Rec."Allow Cheque Deposit")
                {
                    ApplicationArea = All;
                }
                field("Allow Cheque Withdrawal"; Rec."Allow Cheque Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Allow InterAccount Transfer"; Rec."Allow InterAccount Transfer")
                {
                    ApplicationArea = All;
                }
                field("Open Automatically"; Rec."Open Automatically")
                {
                    ApplicationArea = All;
                }
                field("Exclude from Closure"; Rec."Exclude from Closure")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ClosingAccount;
                    end;
                }
            }
            group(Posting)
            {
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Posting Group"; Rec."Ledger Fee Posting Group")
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
        ClosingAccount;
    end;

    var
        CloseAccount: Boolean;

    local procedure ClosingAccount()
    begin
        IF Rec."Exclude from Closure" = TRUE THEN BEGIN
            CloseAccount := FALSE;
        END ELSE BEGIN
            CloseAccount := TRUE;
        END;
    end;
}

