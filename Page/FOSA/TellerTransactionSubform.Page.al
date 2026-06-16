page 50061 "Teller Transaction Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Teller Transaction Line";
    RefreshOnActivate = true;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Teller)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
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

                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update()
                    end;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    Editable = Rec."Is Cheque";
                    Enabled = Rec."Is Cheque";
                    ShowMandatory = Rec."Is Cheque";
                }
                // "Is Bank Deposit"
                field("Bank Acc No"; Rec."Bank Acc No")
                {
                    ApplicationArea = All;
                    Editable = Rec."Is Cheque" or Rec."Is Bank Deposit";
                    Enabled = Rec."Is Cheque" or Rec."Is Bank Deposit";
                    ShowMandatory = Rec."Is Cheque" or Rec."Is Bank Deposit";
                }
            }
        }

    }

    /*  actions
     {
         area(Processing)
         {
             action(Post)
             {
                 ApplicationArea = All;

                 trigger OnAction();
                 begin

                 end;
             }
         }
     } */

    var
        IsCheque: Boolean;

}