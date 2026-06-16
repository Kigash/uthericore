page 50009 "Account Signatory"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Account Signatory";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Identification No."; Rec."Identification No.")
                {
                    ApplicationArea = All;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Front ID"; Rec."Front ID")
                {
                    ApplicationArea = All;
                }
                field("Back ID"; Rec."Back ID")
                {
                    ApplicationArea = All;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(SP; "Signatory Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Account No." = field("Account No."), "Entry No." = field("Entry No.");
            }
            part(FID; "Signatory Front ID")
            {
                ApplicationArea = All;
                Caption = 'Front ID';
                SubPageLink = "Account No." = field("Account No."), "Entry No." = field("Entry No.");
            }
            part(BID; "Signatory Back ID")
            {
                ApplicationArea = All;
                Caption = 'Back ID';
                SubPageLink = "Account No." = field("Account No."), "Entry No." = field("Entry No.");
            }
            part(SIG; "Signatory Signature")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                SubPageLink = "Account No." = field("Account No."), "Entry No." = field("Entry No.");
            }
        }
    }
}