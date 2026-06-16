page 50631 "Checkoff Receipt V. Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Checkoff Receipt Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
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

                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;

                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;

                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;

                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                        CurrPage.Update();
                    end;

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            /*   action(ActionName)
              {
                  ApplicationArea = All;

                  trigger OnAction();
                  begin

                  end;
              } */
        }
    }
}