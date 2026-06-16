page 50303 "Loan Defaulter Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Loan Defaulter Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
                field("Notify Member"; Rec."Notify Member")
                {
                    ApplicationArea = All;
                }

                field("First Notice Template"; Rec."First Notice Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Second Notice Template-Member"; Rec."Second Notice Template-Member")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }

                field("Third Notice-Member"; Rec."Third Notice-Member")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notify Guarantor"; Rec."Notify Guarantor")
                {
                    ApplicationArea = All;
                }
                field("Second Notice-Guarantor"; Rec."Second Notice-Guarantor")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Third Notice-Guarantor"; Rec."Third Notice-Guarantor")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Grace Period"; Rec."Grace Period")
                {
                    ApplicationArea = All;
                }
                field("Attach on"; Rec."Attach on")
                {
                    ApplicationArea = All;
                }
                group(PostingDef)
                {
                    Caption = 'Posting';
                    field("Defaulter Template Name"; Rec."Defaulter Template Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Defaulter Batch Name"; Rec."Defaulter Batch Name")
                    {
                        ApplicationArea = All;
                    }
                }
            }

            group("Demand Letter")
            {
                Caption = 'Demand Letter';
                grid(DemandLetter)
                {
                    group(DemandLetterTemp)
                    {
                        Caption = '';
                        field(DemandLetterTemplate; DemandLetterTemplate)
                        {
                            MultiLine = true;
                            ApplicationArea = All;
                            Caption = '';
                            trigger OnValidate()
                            begin
                                Rec.SetDemandLetterTemplate(DemandLetterTemplate);
                            end;
                        }
                    }
                }
            }
            group(Posting)
            {
                field("Loan Defaulter Template Name"; Rec."Loan Defaulter Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Defaulter Batch Name"; Rec."Loan Defaulter Batch Name")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DemandLetterTemplate := Rec.GetDemandLetterTemplate;
    end;

    var
        DemandLetterTemplate: Text;
}

